module Enumerable
  def my_each
    for v in self
      yield(v)
    end
  end

  def my_each_with_index
    for k, v in self
      yield(k, v)
    end
  end

  def my_map
    res = self.class.new
    self.my_each_with_index do |k, v|
      res[k] = yield(k, v)
    end
    res
  end

  def my_all?(val)
    res = true
    for v in self
      break if !block_given?

      res = res && yield(v)
    end
    for v in self
      break if val.nil?

      res = res && (v == val)
    end
    res
  end

  def my_any?(val)
    res = false
    for v in self
      break unless block_given?

      res = res || yield(v)
    end
    for v in self
      break if val.nil?

      res = res || (v == val)
    end
    res
  end

  def my_none?(val)
    if block_given?
      !self.my_any? {|v| yield(v)}
    else
      !self.my_any? val
    end
  end

  def my_count(val)
    count = 0
    if block_given?
      count = self.my_each { |v| count += 1 if yield(v)}
    elsif !val.nil?
      count = self.my_each { |v| count += 1 if v == val}
    else
      self.length
    end
  end

  def my_filter(val)
    res = self.class.new
    self.my_each_with_index do |k, v|
      res[k] = v if yield(v)
    end
    res
  end

  def my_inject(val)
    if val.nil?
      mem = self[0]
      work = self.drop(1)
    else
      mem = val
      work = self
    end
    for v in work
      mem = yield(mem, v)
    end
    mem
  end
end