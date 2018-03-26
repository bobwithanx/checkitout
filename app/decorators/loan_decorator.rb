module LoanDecorator
  def updated_link
    I18n.l(updated_at.to_s.to_datetime, format: :extended)
  end
end
