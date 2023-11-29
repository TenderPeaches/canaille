class ServiceCategoriesController < ApplicationController
    def pick
        # picked category
        @category = ServiceCategory.find_by_id(params[:id])
        # categories whose parent is @category
        @subcategories = ServiceCategory.where(parent: @category)
        
        respond_to do |format|
            # if there exists a category with ID params[:id]
            if @category 
                format.html { render partial: 'pick', locals: { carousel_categories: @subcategories, breadcrumbs_categories: @category.breadcrumbs, form_object: params[:form_object], selected_category_id: @category.id }, status: :ok }
            # else, if ID is 0, code for "reset" picker so show top-level categories, empty breadcrumbs
            elsif params[:id] == 0.to_s
                format.html { render partial: 'pick', locals: { carousel_categories: ServiceCategory.top_level, form_object: params[:form_object] }, status: :ok}
            # invalid category_id
            else 
                format.html { render partial: 'pick', locals: { form_object: params[:form_object] }, status: :unprocessable_entity }
            end
        end
    end

    private
    def service_category_params

    end
end
