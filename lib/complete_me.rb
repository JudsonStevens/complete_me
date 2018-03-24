require_relative 'node'

class CompleteMe
  attr_accessor :root_node

  def initialize
    @root_node = Node.new
  end

  def insert_new_word(word)
    node = @root_node
    #Take each letter of the input word and ask if the node before has the same
    #letter as a key already. If not, start a new node. If it does, then do nothing.
    word.each_char do |letter|
      if node.child_nodes.has_key?(letter) == false
        node.child_nodes[letter] = Node.new
      end
    end
    #Word flag should change at the end of the method to signify an entire word
    #has been input.
    node.word_flag = true
  end

end

x = CompleteMe.new
x.insert_new_word("example")
