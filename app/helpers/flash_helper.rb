# frozen_string_literal: true

module FlashHelper
  STYLES = {
    success: 'alert-success',
    notice: 'alert-info',
    info: 'alert-info',
    warn: 'alert-warning',
    alert: 'alert-warning',
    error: 'alert-danger'
  }.freeze

  def flash_style(type)
    STYLES[type.to_sym]
  end
end
