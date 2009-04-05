namespace :maintenance do
  
  desc "Block ips"
  task :block_ips => :environment do
    BlockedIp.pending_for_block.each do |ip|
      ip.block!
    end
  end
  
end