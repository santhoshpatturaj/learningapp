module LoginHelper

  def login(student)
    $test_student = student
  end

  def logout
    $test_student = nil
  end

end
