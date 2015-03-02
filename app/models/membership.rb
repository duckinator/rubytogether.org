class Membership < ActiveRecord::Base
  enum kind: %i[individual corporate]

  scope :active, -> { where("expires_at > ?", Time.now) }
  scope :named,  -> { where("name IS NOT NULL") }

  def full_name
    case kind
    when "individual"
      "an individual member"
    when "corporate"
      "a corporate member"
    else
      "a member"
    end
  end

  def status
    if expires_at.nil?
      "pending"
    elsif expires_at > Time.now
      "active"
    else
      "expired"
    end
  end

  def active?
    status == "active"
  end

end