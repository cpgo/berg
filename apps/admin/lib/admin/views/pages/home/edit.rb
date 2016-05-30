require "admin/import"
require "admin/pages/home/forms/edit_form"
require "admin/view"

module Admin
  module Views
    module Pages
      module Home
        class Edit < Admin::View
          include Admin::Import(
            "admin.persistence.repositories.home_page_featured_items",
            "admin.pages.home.forms.edit_form"
          )

          configure do |config|
            config.template = "pages/home/edit"
          end

          def locals(options = {})
            featured_items = {
              home_page_featured_items: home_page_featured_items.listing_by_position.map(&:to_h)
            }

            super.merge(
              page_form: form_data(prepare_values(featured_items), options[:validation]),
              csrf_token: options[:scope].csrf_token
            )
          end

          private

          def form_data(featured_items, validation)
            if validation
              edit_form.build(validation, validation.messages)
            else
              edit_form.build(featured_items)
            end
          end

          def prepare_values(featured_items)
            # TODO
          end
        end
      end
    end
  end
end
