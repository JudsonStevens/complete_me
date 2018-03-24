require_relative 'node'

class CompleteMe
  attr_accessor :root_node,
                :count

  def initialize
    @root_node = Node.new
    @count = 0
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
    @count += 1
  end

  def search(word, node = @root_node)
    #Starting at the root, we need an argument to be able to traverse. Traverse
    #and search are pretty much the same thing. Better to write that as one. Take 
    #in an argument and then strip it down and check each node to see if it has
    #a child node containing that letter. Each child node with the letter should be 
    #checked for the word flag, and then checked against the original word if the flag
    #is set to true. Do we need an array to hold the characters as they are checked,
    #to then be displayed at the end to confirm the word exists? Or just return true,
    #that the search was successful.
    #Ended up not needing to check to see if the word flag is true, as it just needs
    #to find out whether or not the word is contained in the keys of the child nodes.
    new_word = word.each_char do |letter|
      if node.child_nodes.has_key?(letter) == true
        node = node.child_nodes[letter]
      elsif node.child_nodes.has_key? == false
        return false
      end
    end
    #Probably unneccesary, but it returns true if the word is contained in the trie.
    if new_word == word && node.word_flag == true
      final_node = node.word_flag
      return final_node
    elsif new_word == word && node.word_flag != true
      node.word_flag = true
      return true
    end 
  end

  def count
    #Most efficient way to count is to count insertions and lower the count on deletions.
    #This method will return the count.
    return @count
  end

  def populate(strings)
    strings.split("\n").each { |word| insert(word)}
  end
  
end