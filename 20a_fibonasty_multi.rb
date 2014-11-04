=begin
0,1,1,2,3,5,8,13,21,34,55

fibonasty 7 == 13 == (5 + 8)  == fibonasty(5) + fibonasty (6)
=end
def slow_fibonasty n
  if n <= 1
    n
  else
    slow_fibonasty(n-2) + slow_fibonasty(n-1)
  end
end

def fibonasty n
  if n <= 1
    n
  else
    #results = [0,1]
    results = [1,1]
    until results.length == n
      results << results[-1] + results[-2]
    end
  end
  results.last
end
