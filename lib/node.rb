require_relative '../lib/complete_me'
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


