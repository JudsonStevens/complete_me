require "./lib/complete_me"
require "./lib/node"

@cm = CompleteMe.new
class Shoes

Shoes.app do
  stack do
    para "Type something here."
    flow do
      @user_input = edit_box
      @suggestions = []
      @user_input.change do
        @suggestions.replace(@cm.suggest(@user_input.text).join(", "))
      end

    end

    flow do
  @suggestions = para ''
end

  # I need a box here that takes user input

  # @cm should search each word, every time the user presses a key
  # @cm takes this in using populate method

  end
end


end
