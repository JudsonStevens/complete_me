require_relative 'node'

class CompleteMe
  attr_accessor :root_node

  def initialize
    @root_node = Node.new
  end

  def insert_new_word(word)
    node = @root_node
    word.each_char do |letter|
      if node.child_nodes.has_key?(letter) == false
        node.child_nodes[letter] = Node.new
      else
        node.child_nodes[letter]
      end
    end
    
  end

end

