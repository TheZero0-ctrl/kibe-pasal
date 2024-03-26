module RspecScreenshotHelperPatch
  def take_failed_screenshot
    return unless failed? && supports_screenshot? && Capybara::Session.instance_created?

    take_screenshot
  end
end
