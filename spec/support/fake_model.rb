class FakeModel < ActiveRecord::Base
  include Etat::ActiveRecord

  has_states :draft, :published, :deleted

  event :publish do
    self.state = :published
    self
  end

  event :unpublish do
    self.state = :draft
    self
  end

  event :delete do
    self.state = :deleted
    self
  end
end