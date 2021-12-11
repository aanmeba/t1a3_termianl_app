require 'tty-prompt'
require 'colorize'
require_relative './methods'

prompt = TTY::Prompt.new

title = "Split The Bills".colorize(:light_red)

system('clear')
puts "Let's #{title}!"
puts "Enter your name".colorize(:light_blue)
name_array = []
input = gets.chomp.downcase
name_array << input

while input
    system('clear')
    puts "Enter names who you are gonna split the bills one by one.\s\nIf you finish it, please type 'done'".colorize(:light_blue)
    input = gets.chomp.downcase
    if input == "done"    
        if name_array.length == 1
            # puts "You should enter one more person.".colorize(:light_blue)
            prompt.warn("You should enter one more person.")
        else
            break
        end
    else
        name_array << input
        name_array.each_with_index {|name, index| puts "#{index+1}. #{name.capitalize}"}
    end
end

bill_validation = true
while bill_validation
    system('clear')
    puts "Enter the total amount".colorize(:light_blue)
    bill = gets.chomp.to_f

    yes_no = prompt.yes?("The total amount is #{bill}, is it correct?".colorize(:light_blue)) do |q|
        q.required true
        q.modify   :down
    end
    
    case yes_no
    when true
        puts "Alright, let's split the bill."
        bill_validation = false        
    when false
        puts "Please enter the correct amount."
    end
   
end

system('clear')
calculator_instance = Calculator.new(name_array, bill)

choices = [
        {name: 'I\'m feeling lucky!', value: 1},
        {name: 'Equally', value: 2},
        {name: 'Manually', value: 3},
        {name: 'Exit', value: 4}
      ]

user_input = prompt.select("Choose how you are going to split the bill.", choices)

num = name_array.length

case user_input
when 1
    # y_n_input = prompt.yes?("Would you like to set a maximum amount for each person?") do |q|
    #     q.required true
    #     q.modify   :down
    # end

    # case y_n_input
    # when true
    #     maximum = get.chomp.to_f

    # when false
        amount_array = calculator_instance.split_randomly(num, bill)
        calculator_instance.display_randomly_manually(name_array, amount_array)
        exit
    # end
    
when 2
    puts "Alright, let's split the bill equally..."
    
    return_value = calculator_instance.split_equally(num, bill)
    calculator_instance.display_equally(name_array, return_value)
    exit
when 3
    manual_return = calculator_instance.split_manually(name_array, bill)
    calculator_instance.display_randomly_manually(name_array, manual_return)
    exit

when 4
    puts "Bye for now!"
end
