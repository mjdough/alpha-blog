require 'test-helper'

class CreateCategoriesTest < ActionDespatch::Integration
    
    test "get new category forma and create category" do
        get new_category_path
        assert_template 'categories/new'
        assert_difference 'Category count', 1 do
            post_via_redirect categories_path, category: {name: "sports"}
        end
        assert_template 'categories/index'
        assert_match "sports", response.body
    end
    
    test "invalid category submissionresults in failure" do
        get new_category_path
        assert_template 'categories/new'
        assert_no_difference 'Category.count' do
            post categories_path, category: {name: " "}
        end
        assert_template 'categories/new'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end
end