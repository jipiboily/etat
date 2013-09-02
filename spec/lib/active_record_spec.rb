require 'spec_helper'

describe Etat::ActiveRecord do
  describe '.states' do
    it { expect(FakeModel.states).to eq [:draft, :published, :deleted] }
  end

  describe :scopes do
    before do
      published = create_list(:published, 4)
      drafts = create_list(:draft, 3)
      deleted = create_list(:deleted, 2)
      @counts_per_state = {
        published: published.size,
        deleted: deleted.size,
        draft: drafts.size,
        total: (published.size + deleted.size + drafts.size)
      }
    end

    FakeModel.states.each do |state|
      describe ".all_#{state}" do
        it "returns only '#{state}' records" do
          expect(FakeModel.send("all_#{state}").count).to eq @counts_per_state[state]
        end
      end

      describe ".all_but_#{state}" do
        it "returns all records besides '#{state}' ones" do
          expect(FakeModel.send("all_but_#{state}").count).to eq (@counts_per_state[:total] - @counts_per_state[state])
        end
      end

      describe "##{state}?" do
        it 'returns true if this is the current state' do
          expect(FakeModel.new(state: state).send("#{state}?")).to be_true
        end

        it 'returns false if this is not the current state' do
          expect(FakeModel.new(state: 'invalid state').send("#{state}?")).to be_false
        end
      end
    end
  end

  describe '.event' do
    it { expect(FakeModel.new.publish.draft?).to be_false }
    it { expect(FakeModel.new.publish.published?).to be_true }
    it { expect(FakeModel.new.publish.deleted?).to be_false }

    it { expect(FakeModel.new.unpublish.draft?).to be_true }
    it { expect(FakeModel.new.unpublish.published?).to be_false }
    it { expect(FakeModel.new.unpublish.deleted?).to be_false }

    it { expect(FakeModel.new.delete.draft?).to be_false }
    it { expect(FakeModel.new.delete.published?).to be_false }
    it { expect(FakeModel.new.delete.deleted?).to be_true }
  end

  describe '#state' do
    it { expect(FakeModel.new(state: 'draft').state).to be_a Symbol }
    it { expect(FakeModel.new(state: 'draft').state).to eq :draft }
  end
end