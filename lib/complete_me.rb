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
    #final node value equal to the last letter.
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

  def search(word)
    node = @root_node
    #Starting at the root, we need an argument to be able to traverse. Traverse
    #and search are pretty much the same thing. Better to write that as one. Take 
    #in an argument and then strip it down and check each node to see if it has
    #a child node containing that letter. Each child node with the letter should be 
    #checked for the word flag, and then checked against the original word if the flag
    #is set to true.
    word.each_char do |letter|
      if node.child_nodes.has_key?(letter) == true
        node.child_nodes[letter] = node
      elsif node.child_nodes.has_key?
    
  end

end
