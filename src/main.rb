# Main file for the 'Split The Bills' app

# Gems
require 'tty-prompt'
require 'colorize'
require 'artii'

# Imports other files
require_relative './methods'
require_relative './command-line-arg'
require_relative './Calculator'

# Global variables for colours used in different files
$instruction = :light_blue
$highlight = :light_red
$err_msg = ">>".colorize($highlight)

prompt = TTY::Prompt.new
Arti = Artii::Base.new :font => 'slant'

title = "Split The Bills"
name_array = []
input = ""

# system('clear')
# puts Arti.asciify(title)
# puts " Let's #{title}! ".colorize(:black).on_light_blue
heading(title)
puts "Enter names one by one.\s\nPlease " + "type 'done' ".colorize($instruction) + "when you finish."

# Names input
while input
    input = prompt.ask("Name:", required: true) do |q|
        q.validate(/^[A-Za-z ]*$/)
        q.messages[:valid?] = "Please enter only alphabetical letters"
        q.modify :chomp, :down
    end

    if input == "done"    
        if name_array.size <= 1
            puts $err_msg + " You should provide more than two people"
        else
            break
        end
    else
        name_array << input
        name_array.each_with_index { |name, index| puts "#{index+1}. #{name.capitalize}" }
    end
end

# Bill validation loop
bill_validation = true
while bill_validation
    heading(title)

    bill = prompt.ask("Enter the total amount", required: true, convert: :float) do |q|
        q.validate(/^(?:[1-9]\d*|0(?!(?:\.0+)?$))?(?:\.\d+)?$/)
        q.messages[:valid?] = "Please provide positive numbers"
        q.modify :chomp
        q.messages[:convert?] = "Please provide positive numbers"
    end
    bill = bill.round(2)

    yes_no = prompt.yes?("The total amount is " + "#{bill}".colorize($instruction) + ", is it correct?") do |q|
        q.required true
        q.modify   :down
    end
    
    case yes_no
    when true
        bill_validation = false        
    end
end

heading(title)
# Generates an instance of Calculator class
calculator_instance = Calculator.new(name_array, bill, title)

while true
    choices = [
            {name: 'Randomly', value: 1},
            {name: 'Equally', value: 2},
            {name: 'Manually', value: 3},
            {name: 'Exit', value: 4}
        ]
    user_input = prompt.select("Choose how you are going to split the bill.", choices)

    system('clear')

    case user_input
    when 1
        amount_array = calculator_instance.split_randomly
        calculator_instance.display(amount_array)
        # want_to_exit
    when 2    
        result_array = calculator_instance.split_equally
        calculator_instance.display(result_array)
        # want_to_exit
    when 3
        manual_return = calculator_instance.split_manually
        calculator_instance.display(manual_return)
        # want_to_exit
    when 4
        heading(title)
        puts "Bye for now!"
        exit
    end
end
