require 'tty-prompt'
require 'colorize'
require_relative './methods'


system('clear')
prompt = TTY::Prompt.new

title = "Split The Bills".colorize(:light_red)

puts "Let's #{title}!"
# puts "Enter your name".colorize(:light_blue)
name_array = []
# input = gets.chomp.downcase
input = prompt.ask("Enter your name".colorize(:light_blue), required: true) do |q|
    q.validate(/^[A-Za-z ]*$/)
    q.messages[:valid?] = "Please enter only alphabetical letters"
    q.modify :chomp, :down
end

name_array << input

system('clear')
# puts "If you finish it, please type 'done'".colorize(:light_blue)

while input
    
    input = prompt.ask("Enter other names one by one.\s\nPlease type 'done' when you finish it".colorize(:light_blue), required: true) do |q|
        q.validate(/^[A-Za-z ]*$/)
        q.messages[:valid?] = "Please enter only alphabetical letters"
        q.modify :chomp, :down
    end

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

    bill = prompt.ask("Enter the total amount".colorize(:light_blue), required: true, convert: :float) do |q|
        q.validate(/^(?:[1-9]\d*|0(?!(?:\.0+)?$))?(?:\.\d+)?$/)
        q.messages[:valid?] = "Please provide positive numbers"
        q.modify :chomp
        q.messages[:convert?] = "Please provide positive numbers"
    end

    bill = bill.round(2)

    yes_no = prompt.yes?("The total amount is #{bill}, is it correct?".colorize(:light_blue)) do |q|
        q.required true
        q.modify   :down
    end
    
    case yes_no
    when true
        bill_validation = false        
    when false
        puts "Please enter the correct amount."
    end
    
end

system('clear')
calculator_instance = Calculator.new(name_array, bill)

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
    exit

when 2
    puts "Alright, let's split the bill equally..."
    
    result_array = calculator_instance.split_equally
    calculator_instance.display(result_array)
    exit
when 3
    manual_return = calculator_instance.split_manually
    calculator_instance.display(manual_return)
    exit

when 4
    puts "Bye for now!"
end
