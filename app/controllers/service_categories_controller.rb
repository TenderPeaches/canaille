class ServiceCategoriesController < ApplicationController
    def pick
        # picked category
        @category = ServiceCategory.find_by_id(params[:id])
        # categories whose parent is @category
        @subcategories = ServiceCategory.where(parent: @category)
        
        respond_to do |format|
            # if there exists a category with ID params[:id]
            if @category 
                format.html { render partial: 'pick', locals: { carousel_categories: @subcategories, breadcrumbs_categories: @category.breadcrumbs, selected_category_id: @category.id }, status: :ok }
                format.turbo_stream { render 'pick', locals: { service_category: @category }}
            # else, if ID is 0, code for "reset" picker so show top-level categories, empty breadcrumbs
            elsif params[:id] == 0.to_s
                format.html { render partial: 'pick', locals: { carousel_categories: ServiceCategory.top_level }, status: :ok}
                format.turbo_stream { render 'pick', locals: { service_category: nil }}
            # invalid category_id
            else 
                format.html { render partial: 'pick', locals: {}, status: :unprocessable_entity }
                format.turbo_stream { render 'pick', locals: { service_category: nil }, status: :unprocessable_entity }
            end
        
        end
    end

    private
    def service_category_params

    end
end
