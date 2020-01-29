module ControllerHelper
  def message(context:, subject:)
    return "There are no #{subject} yet" if context.empty?

    "All #{subject} successfully retrieved"
  end
end
