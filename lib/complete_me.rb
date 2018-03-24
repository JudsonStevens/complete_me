require_relative 'node'

class CompleteMe
  attr_accessor :root_node,
                :count
                # :final_word_suggestions

  def initialize
    @root_node = Node.new
    @count = 0
    # @final_word_suggestions = []
  end

  def insert(word, node = @root_node)
    #Take each letter of the input word and ask if the node before has the same
    #letter as a key already. If not, start a new node. If it does, then set the 
    #final node value equal to the last letter.
    word.each_char.map do |letter|
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
    #The definition list in the local computer is divided by \n, allowing
    #it to be split into seperate words and then inserted.
    strings.split("\n").each { |word| insert(word)}
  end
  
  #To suggest, we need to first find the node at the end of the prefix given. 
  #After that, we need to find all words that use that prefix and have a valid
  #word_flag to signify they are a word.
  def suggest(prefix, node = @root_node)
    final_word_suggestions = []
    prefix.each_char do |letter|
      if node.child_nodes.has_key?(letter) == true
        node = node.child_nodes[letter]
      end
    end
    final_word_suggestions = all_words(node, prefix, final_word_suggestions)
    return final_word_suggestions
  end

  #This method takes the node from the original suggest method and then finds
  #the nodes with the word_flag set to true, returning the characters it used
  #to get to that node as a valid word suggestion.
  def all_words(node, prefix, final_word_suggestions)
    if node.word_flag == true
      final_word_suggestion_intake(prefix, final_word_suggestions)
    end
    if node.child_nodes.empty? == false
      suggestion_search(node, prefix, final_word_suggestions)
    end
    return final_word_suggestions
  end

  def suggestion_search(node, prefix, final_word_suggestions)
    node.child_nodes.keys.each do |letter|
      if node.child_nodes.has_key?(letter)
        new_prefix = prefix
        new_prefix += letter
        next_node = node.child_nodes[letter]
        all_words(next_node, new_prefix, final_word_suggestions)
      end
    end
  end

  def final_word_suggestion_intake(prefix, final_word_suggestions)
    final_word_suggestions << prefix 
    final_word_suggestions = final_word_suggestions.uniq
  end
end
