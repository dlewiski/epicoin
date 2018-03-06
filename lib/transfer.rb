class Transfer < ActiveRecord::Base
  belongs_to :sender, :class_name => "Peer"
  belongs_to :recipient, :class_name => "Peer"
  belongs_to :block

end

# belongs to two peers
# belongs to block
