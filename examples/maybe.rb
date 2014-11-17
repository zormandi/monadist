require 'monadist'
require 'monadist/shims'
require 'active_support/all'



def lead_conversion_rate_history(customer_metrics)
  customer_metrics[:lead][:conversion][:rate][:history]
end



def lead_conversion_rate_history_safe(customer_metrics)
  unless customer_metrics.nil?
    unless customer_metrics[:lead].nil?
      unless customer_metrics[:lead][:conversion].nil?
        unless customer_metrics[:lead][:conversion][:rate].nil?
          unless customer_metrics[:lead][:conversion][:rate][:history].nil?
            customer_metrics[:lead][:conversion][:rate][:history]
          end
        end
      end
    end
  end
end



def lead_conversion_rate_history_fetch(customer_metrics)
  customer_metrics ||= {}
  customer_metrics.
    fetch(:lead, {}).
    fetch(:conversion, {}).
    fetch(:rate, {}).
    fetch(:history, nil)
end



def lead_conversion_rate_history_try(customer_metrics)
  customer_metrics.
    try { |metrics| metrics[:lead] }.
    try { |lead_metrics| lead_metrics[:conversion] }.
    try { |lead_conversion_metrics| lead_conversion_metrics[:rate] }.
    try { |lead_conversion_rate_metrics| lead_conversion_rate_metrics[:history] }
end



def lead_conversion_rate_history_maybe_bind(customer_metrics)
  Monadist::Maybe.unit(customer_metrics).
    bind { |metrics| Monadist::Maybe.unit(metrics[:lead]) }.
    bind { |lead_metrics| Monadist::Maybe.unit(lead_metrics[:conversion]) }.
    bind { |lead_conversion_metrics| Monadist::Maybe.unit(lead_conversion_metrics[:rate]) }.
    bind { |lead_conversion_rate_metrics| Monadist::Maybe.unit(lead_conversion_rate_metrics[:history]) }.
    value
end



def lead_conversion_rate_history_maybe_fmap(customer_metrics)
  Monadist::Maybe.unit(customer_metrics).
    fmap { |metrics| metrics[:lead] }.
    fmap { |lead_metrics| lead_metrics[:conversion] }.
    fmap { |lead_conversion_metrics| lead_conversion_metrics[:rate] }.
    fmap { |lead_conversion_rate_metrics| lead_conversion_rate_metrics[:history] }.
    value
end



def lead_conversion_rate_history_maybe_sugar(customer_metrics)
  possibly_nil(customer_metrics)[:lead][:conversion][:rate][:history].value
end



customer_metrics = {
  lead: {
    conversion: {}
  }
}

# p lead_conversion_rate_history customer_metrics
p lead_conversion_rate_history_safe customer_metrics
p lead_conversion_rate_history_fetch customer_metrics
p lead_conversion_rate_history_try customer_metrics
p lead_conversion_rate_history_maybe_bind customer_metrics
p lead_conversion_rate_history_maybe_fmap customer_metrics
p lead_conversion_rate_history_maybe_sugar customer_metrics
