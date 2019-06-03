module ApplicationHelper
  def boolean_display(bool)
    bool ? octicon('check') : octicon('x')
  end
end
