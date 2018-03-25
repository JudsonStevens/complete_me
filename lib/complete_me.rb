require_relative 'node'

class CompleteMe
  attr_accessor :root_node,
                :count  

  def initialize
    @root_node = Node.new
    @count = 0
  end

  def insert(word, node = @root_node)
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
    if new_word == word && node.word_flag == true
      return node
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
  def suggest(substring, node = @root_node)
    final_word_suggestions = []
    substring.each_char do |letter|
      if node.child_nodes.key?(letter) == true
        node = node.child_nodes[letter]
      end
    end
    final_word_suggestions = all_words(node, substring, final_word_suggestions)
    final_word_suggestions = sort_weighted_suggestions(substring, final_word_suggestions)
    return final_word_suggestions.map {|suggestion| suggestion[0]}
  end

  #This method takes the node from the original suggest method and then finds
  #the nodes with the word_flag set to true, returning the characters it used
  #to get to that node as a valid word suggestion.
  def all_words(node, substring, final_word_suggestions)
    if node.word_flag == true
      final_word_suggestion_intake(substring, final_word_suggestions)
    end
    if node.child_nodes.empty? == false
      suggestion_search(node, substring, final_word_suggestions)
    end
    return final_word_suggestions
  end

  def suggestion_search(node, substring, final_word_suggestions)
    node.child_nodes.each_key do |letter|
      if node.child_nodes.key?(letter)
        new_substring = substring
        new_substring += letter
        next_node = node.child_nodes[letter]
        all_words(next_node, new_substring, final_word_suggestions)
      end
    end
  end

  def final_word_suggestion_intake(substring, final_word_suggestions)
    final_word_suggestions << substring
    final_word_suggestions = final_word_suggestions.uniq
  end

  #Take in the substring and the suggestion, and weight the word picked,
  #increasing the weight by 1, to influence presentation using the same
  #substring. This doesn't work if we are looking for a weighted variable
  #depending on the substring input. We need to weight the end words
  #based on the substring by using a hash with keys for each substring
  #and a value of the number of times its been selected.
  def select(substring, selected_suggestion)
    node = search(selected_suggestion)
    if node.weight.key?(substring)
      node.weight[substring] += 1
    else
      node.weight[substring] = 1
    end
  end

  #We need to sort the answers by weight, so we take in the substring and the array of 
  #suggestions given by the suggest method. We find the node for each one, and if the weight
  #hash is nil, we set that value to zero to make the calculations easier. We then feed
  #an array of the word and it's weight into the weighted_suggestions array and sort that
  #by the weight value. We then reverse the array to get descending order and return it.
  def sort_weighted_suggestions(substring, final_word_suggestion)
    weighted_suggestions = []
    final_word_suggestion.map do |word|
      node = search(word)
      node.weight[substring] = 0 if node.weight[substring] == nil
      weighted_suggestions << [word, node.weight[substring]]
    end
    sorted_word_suggestions = sort_suggestions_into_correct_order(weighted_suggestions)
    return sorted_word_suggestions
  end

  def sort_suggestions_into_correct_order(weighted_suggestions)
    weighted_suggestions.compact
    sorted_word_suggestions = weighted_suggestions.sort_by { |weight| weight[1]}
    sorted_word_suggestions = sorted_word_suggestions.reverse
  end

end
