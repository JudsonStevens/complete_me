require_relative 'node'
require 'csv'

class CompleteMe
  attr_accessor :root_node,
                :count

  def initialize
    @root_node = Node.new
    @word_log = []
  end

  # Take each letter of the input word and ask if the node before has the same
  # letter as a key already. If not, start a new node. If it does, then set the
  # final node value equal to the last letter. Once it's ran through all of the
  # characters, it sets the word_flag = true.
  def insert(word, node = @root_node)
    @word_log << word
    word.each_char { |letter|
      if node.child_nodes.has_key?(letter) == false
        node.child_nodes[letter] = Node.new
      end
      node = node.child_nodes[letter] }
    node.word_flag = true
  end

  # Take in an argument and then strip it down and check each node to see if it has
  # a child node containing that letter. Once the new_word has ran through all of the
  # characters in the supplied word, and found nodes for all of them, it returns the
  # node of the last character in the word we wanted to find. The last if statement
  # just double checks to make sure we returned the right new_word. Possibly
  # extraneous, discuss on Monday.
  def search(word, node = @root_node)
    new_word = word.each_char do |letter|
      if node.child_nodes.has_key?(letter) == true
        node = node.child_nodes[letter]
      else return false
      end 
    end
    return node if new_word == word
  end

  # This method will be used to count the existing words in the trie. We
  # set the instance variable @count equal to zero to start, then move to
  # the actual_count method.
  def count(node = @root_node)
    @count = 0
    actual_count(node)
  end

  # This method asks if the child nodes of that node are not empty. If they
  # are not, then we take each child node and perform the count_conditionals
  # method, which will increase the count if there is a word_flag that is set
  # to true among the child nodes.
  def actual_count(node = @root_node)
    if node.child_nodes.empty? == false
      node.child_nodes.each_key do |letter|
        count_conditionals(node, letter)
      end
    end
    return @count
  end

  def count_conditionals(node, letter)
    if node.child_nodes[letter].word_flag == true
      @count += 1
      actual_count(node.child_nodes[letter])
    elsif node.child_nodes[letter].word_flag == false
      actual_count(node.child_nodes[letter])
    end
  end

  # The definition list in the local computer is divided by \n, allowing
  # it to be split into seperate words and then inserted.
  def populate(strings)
    strings.split("\n").uniq.each { |word| insert(word) }
  end

  # To suggest, we need to first find the node at the end of the prefix given.
  # After that, we need to find all words that use that prefix and have a valid
  # word_flag to signify they are a word.
  def suggest(substring, mid_word = false, node = @root_node )
    final_word_sugg = []
    substring.each_char do |letter|
      node = node.child_nodes[letter] if node.child_nodes.key?(letter) == true
    end
    final_word_sugg = find_final_word_sugg(node, substring, final_word_sugg, mid_word)
    return final_word_sugg.map { |suggestion| suggestion[0] }
  end

  def find_final_word_sugg(node, substring, final_word_sugg, mid_word)
    final_word_sugg = find_all_words(node, substring, final_word_sugg)
    if mid_word == true
      final_word_sugg += dictionary_search(substring)
      final_word_sugg = final_word_sugg.uniq.reverse
    end
    final_word_sugg = sort_weighted_suggestions(substring, final_word_sugg)
  end

  # This method takes the node from the original suggest method and then finds
  # the nodes with the word_flag set to true, returning the characters it used
  # to get to that node as a valid word suggestion.
  def find_all_words(node, substring, final_word_sugg)
    if node.word_flag == true
      final_word_suggestion_intake(substring, final_word_sugg)
    end
    if node.child_nodes.empty? == false
      suggestion_search(node, substring, final_word_sugg)
    end
    return final_word_sugg
  end

  def suggestion_search(node, substring, final_word_sugg)
    node.child_nodes.each_key do |letter|
      if node.child_nodes.key?(letter)
        recursive_suggestion_search(node, letter, substring, final_word_sugg)
      end
    end
  end

  def recursive_suggestion_search(node, letter, substring, final_word_sugg)
    new_substring = substring
    new_substring += letter
    next_node = node.child_nodes[letter]
    find_all_words(next_node, new_substring, final_word_sugg)
  end

  def final_word_suggestion_intake(substring, final_word_sugg)
    final_word_sugg << substring
    final_word_sugg = final_word_sugg.uniq
  end

  # Take in the substring and the suggestion, and weight the word picked,
  # increasing the weight by 1, to influence presentation using the same
  # substring. This doesn't work if we are looking for a weighted variable
  # depending on the substring input. We need to weight the end words
  # based on the substring by using a hash with keys for each substring
  # and a value of the number of times its been selected.
  def select(substring, selected_suggestion)
    node = search(selected_suggestion)
    if node.weight.key?(substring)
      node.weight[substring] += 1
    else
      node.weight[substring] = 1
    end
  end

  # We need to sort the answers by weight, so we take in the substring and the array of
  # suggestions given by the suggest method. We find the node for each one, and if the weight
  # hash is nil, we set that value to zero to make the calculations easier. We then feed
  # an array of the word and it's weight into the weighted_suggestions array and sort that
  # by the weight value. We then reverse the array to get descending order and return it.
  def sort_weighted_suggestions(substring, final_word_suggestion)
    weighted_suggestions = []
    final_word_suggestion.map do |word|
      addition_to_weighted_suggestions(word, substring, weighted_suggestions)
    end
    sorted_word_suggestions = sort_into_correct_order(weighted_suggestions)
    return sorted_word_suggestions
  end

  def addition_to_weighted_suggestions(word, substring, weighted_suggestions)
    node = search(word)
    node.weight[substring] = 0 if node.weight[substring] == nil
    weighted_suggestions << [word, node.weight[substring]]
    return weighted_suggestions
  end

  def sort_into_correct_order(weighted_suggestions)
    weighted_suggestions.compact
    sorted_word_suggestions = weighted_suggestions.sort_by { |weight| weight[1] }
    sorted_word_suggestions = sorted_word_suggestions.reverse
  end

  # This method just checks to see if a word is included by running the search
  # method. If search returns false, we can say it's not included in the list.
  # If search returns anything other than false, then we know the word is included.
  def include?(word)
    test_node = search(word)
    if test_node == false
      return false
    else
      return true
    end
  end

  # To delete a node, first we find the last node in the substring. This would be the "d" in
  # "wizard", for example. Once we have that, we ask whether the child nodes are empty. If they are not,
  # then the solution is simple, we set the word flag of that "d" node to false to
  # indicate it is not the end of a word anymore and we are done. If the node is a leaf,
  # it's a bit more complicated. We send the substring and node over to the
  # delete_and_move_to_previous_node method.
  def delete(substring)
    node = search(substring)
    if node.child_nodes.empty?
      delete_and_move_to_previous_node(substring)
    elsif node.child_nodes.empty? == false
      node.word_flag = false
    end 
  end

  # This method comes into play if the node we want to delete doesn't have any children.
  # We set last_letter equal to the last letter in the substring and make the substring
  # equal to the original string minus the first letter. We then find the node for that
  # substring. The search then finds the node for the substring without the last letter.
  # This allows us to ask whether or not that letter contains the last_letter as a child,
  # and also we check to make sure it's not the ending of another word already. If the node
  # we end up on has a word_flag of true, then we run the actual delete portion of the
  # method one more time and end. The delete portion takes the array of hashes of
  # the letters, duplicates it, and uses .tap to chain on the actual delete of the
  # hash containing the character we are removing. This method returns the new array
  # of hashes, which is stored as the node's new child_nodes. The delete is run again
  # until the node it ends up on has a word_flag of true.
  def delete_and_move_to_previous_node(substring)
    last_letter = substring[-1]
    substring = substring[0...-1]
    node = search(substring)
    actual_deletion(node, last_letter, substring)
  end

  def actual_deletion(node, last_letter, substring)
    if node.child_nodes.key?(last_letter) && node.word_flag == false
      node.child_nodes = node.child_nodes.dup.tap { |hash| hash.delete(last_letter) }
      delete(substring)
    elsif node.child_nodes.key?(last_letter) && node.word_flag == true
      node.child_nodes = node.child_nodes.dup.tap { |hash| hash.delete(last_letter) }
    end
  end

  def read_CSV_file
    column_data = []
    csv = CSV.foreach('addresses.csv') do
      |row| column_data << row[20]
    end
    populate(column_data.join("\n"))
  end

  def dictionary_search(substring)
    dict_search_results = []
    dict_search_results = @word_log.grep(/#{substring}/).join(" ").split(" ")
    return dict_search_results
  end
end