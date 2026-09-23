module RecordsHelper
  def companion_names_to_display(record)
    @submitted_companion_names || record.companions.pluck(:companion_name)
  end
end
