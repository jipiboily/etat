FactoryGirl.define do
  factory :draft, class: FakeModel do
    state :draft
  end

  factory :published, class: FakeModel do
    state :published
  end

  factory :deleted, class: FakeModel do
    state :deleted
  end
end