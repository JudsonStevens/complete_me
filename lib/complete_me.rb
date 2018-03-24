require_relative 'node'

class CompleteMe
  attr_accessor :root_node

  def initialize
    @root_node = Node.new
  end

  def insert(word)
    node = @root_node
    #Take each letter of the input word and ask if the node before has the same
    #letter as a key already. If not, start a new node. If it does, then set the 
    #final node equal to the node with the last letter in it.
    word.each_char do |letter|
      if node.child_nodes.has_key?(letter) == false
        node.child_nodes[letter] = Node.new
      end
      node = node.child_nodes[letter]
    end
    #Word flag should change at the end of the method to signify an entire word
    #has been input.
    node.word_flag = true
  end

end
