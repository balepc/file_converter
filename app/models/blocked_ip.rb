class BlockedIp < ActiveRecord::Base
  
  before_save :change_status
  
  STATUS_NONE    = 'none'
  STATUS_BLOCK   = 'block'
  STATUS_BLOCKED = 'blocked'
  
  named_scope :pending_for_block, {:conditions => ["status = ?", STATUS_BLOCK]}
  
  def BlockedIp.unverified_request!(ip_address)
    ip = BlockedIp.find_by_ip_address(ip_address)
    ip ||= BlockedIp.new(:ip_address => ip_address)
    ip.violation!
    false
  end
  
  def violation!
    self.attempts += 1
    self.save
  end
  
  def block!
    `iptables -I INPUT -s #{self.ip_address} -j DROP`
    self.update_attribute(:status, STATUS_BLOCKED)
    AdminNotifier.deliver_ip_blocked(self)
    self.save
  end
  
  private
  def change_status
    if self.attempts > 5 and self.status != STATUS_BLOCKED
      self.status = STATUS_BLOCK
    end
  end
  
end
