class Challenges

  def self.addition(level, format ='plain')

    if level.nil? then level=1 end
    if level < 10
      variables = [Random.rand(level/2 + 1) + level/2, Random.rand(level + 1)]
    elsif level < 15
      variables = [Random.rand(level - 10) + level, Random.rand(level * 2 - 10)]
    elsif level < 20
      variables = [Random.rand(level * 2 - 25) + level, Random.rand(level * 3 - 25)]
    else
      variables = [Random.rand((level - 18)*4), Random.rand((level - 18)*4), Random.rand((level - 18)*4)]
    end

    if format == 'plain'
      statement = variables.join(' + ')
      statement += ' = '
      answer = variables.sum
      return statement, answer
    else

    end

  end

end