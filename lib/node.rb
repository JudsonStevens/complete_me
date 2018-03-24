
class Node
  attr_accessor :word_flag,
                :children,
                :weight

  def initialize
    @word_flag = false
    @children = {}
    @weight = {}
  end
  
end


