
class Node
  attr_accessor :word_flag,
                :child_nodes,
                :weight

  def initialize
    @word_flag = false
    @child_nodes = {}
    @weight = {}
  end
  
end


