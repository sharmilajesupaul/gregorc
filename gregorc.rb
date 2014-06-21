QUESTIONS =   [["Imaginative","Investigative","Realistic","Analytical"],
               ["Organized","Adaptable","Critical","Inquisitive"],
               ["Debating","Getting to the point","Creating","Relating"],
               ["Personal","Practical","Academic","Adventurous"],
               ["Precise","Flexible","Systematic","Inventive"],
               ["Sharing","Orderly","Sensible","Independent"],
               ["Competitive","Perfectionist","Cooperative","Logical"],
               ["Intellectual","Sensitive","Hardworking","Risk-taking"],
               ["Reader","People person","Problem Solver","Planner"],
               ["Memorize","Associate","Think-through","Originate"],
               ["Changer","Judger","Spontaneous","Wants direction"],
               ["Communicating","Discovering","Cautious","Reasoning"],
               ["Challenging","Practicing","Caring","Examining"],
               ["Completing work","Seeing possibilities","Gaining ideas","Interpreting"],
               ["Doing","Feeling","Thinking","Experimenting"]]

SCORING_KEY = [[2, 3, 0, 1],
               [0, 2, 1, 3],
               [1, 0, 3, 2],
               [1, 2, 0, 3],
               [0, 2, 1, 3],
               [1, 2, 0, 3],
               [1, 3, 2, 0],
               [2, 0, 1, 3],
               [3, 0, 1, 2],
               [0, 2, 1, 3],
               [3, 1, 2, 0],
               [2, 3, 0, 1],
               [1, 3, 2, 0],
               [0, 2, 3, 1],
               [0, 2, 1, 3]]

def get_answers
  clear_screen
  answers = []
  QUESTIONS.each_with_index do |question, qidx|
    puts "Question #{qidx+1} of #{QUESTIONS.length}. Please enter the two that best describe you:"
    puts question.map.with_index {|option, oidx| "#{oidx}. #{option}"}
    puts ""
    answer = []
    until valid_answer?(answer)
      print "Selection (seperated by spaces):"
      answer = gets.chomp.split(" ").map{|choice| choice.to_i if choice =~ /\d/}
    end
    answers << answer
    clear_screen
  end
  answers
end


def score(answers)
  scoring_columns = SCORING_KEY.transpose
  scores = [0,0,0,0]

  SCORING_KEY.each_with_index do |scoring, row_idx|
    answers.each_with_index do |answer, column_idx|
      if answer.include?(SCORING_KEY[row_idx][column_idx])
        scores[column_idx] += 4
      end
    end
  end
  scores
end

def valid_answer?(answer)
  answer.length == 2 &&
  answer.all?{|answer| answer.is_a? Fixnum} &&
  answer.all?{|answer| answer >= 0 && answer <= 3 }
end

def clear_screen
  print "\e[H"
  print "\e[2J"
end

def print_results(scores)
  types = ["Concrete Sequential",
           "Abstract Sequential",
           "Abstract Random",
           "Concrete Random"]

  puts "Your Results:"
  types.zip(scores).each do |type, result|
    puts "#{type}: #{result}"
  end
  puts "\nMore info: http://web.cortland.edu/andersmd/learning/gregorc.htm"
end

print_results(score(get_answers))
