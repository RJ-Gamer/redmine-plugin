class DashboardController < ApplicationController
   $purchase_tracker_id = 5
    def index
        @statuses = IssueStatus.all
        @issues = Issue.all
        @projects = Project.all
        @order_type_cf_id = 125
        @purchase_status_cf_id = 26

        # SELECT status, count(*) from issues WHERE tracker_id = 5 GROUP BY status;
        @issues_seperated_by_statuses = []
        @issues_seperated_by_order_type = []
        @issues_seperated_by_purchase_status = []

        # all purchase issues
        @purchase_issues = IssueQuery.new(:filters => {
            "tracker_id" => {:operator => "=", :values => ["#{$purchase_tracker_id}"]}
            })
        @purchase_issues_count = Issue.where(:tracker_id => $purchase_tracker_id).count

        # all purchase issues categorised by statuses
        @issues_by_statuses = Issue.where(:tracker_id => $purchase_tracker_id).group(:status).count
        @sorted_by_status_id = IssueQuery.new(:filters =>{
            "status_id" => {:operator => "=", :values => [" "]},
            "tracker_id" => {:operator => "=", :values => ["#{$purchase_tracker_id}"]}
            })
        # @issues_seperated_by_statuses << @sorted_by_status_id

        @issues_count_by_order_type = CustomValue.where(:custom_field_id => @order_type_cf_id).group(:value).count
        @order_type_issues = IssueQuery.new(:filters => {
            "tracker_id" => {:operator => "=", :values => ["#{$purchase_tracker_id}"]},
            "status_id" => {:operator => "=", :values => ["*"]},
            "cf_125" => {:operator => "=", :values => [" "]}
            })

        @issues_count_by_purchase_status = CustomValue.where(:custom_field_id => @purchase_status_cf_id).group(:value).count
        @sorted_by_purchase_status = IssueQuery.new(:filters => {
            "tracker_id" => {:operator => "=", :values => ["#{$purchase_tracker_id}"]},
            "cf_26" => {:operator => "=", :values => [" "]},
            "status_id" => {:operator => "=", :values => ["*"]}
            })
        @priorities = Enumeration.where(:type => "IssuePriority")
        @issues_count_by_priority = Issue.where(:tracker_id => $purchase_tracker_id).group(:priority_id).count
        @issues_by_priority = IssueQuery.new(:filters => {
            "tracker_id" => {:operator => "=", :values => ["#{$purchase_tracker_id}"]},
            "status_id" => {:operator => "=", :values => ["*"]},
            "priority_id" => {:operator => "=", :values => [" "]}
            })
    end
end
