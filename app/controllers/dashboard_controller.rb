class DashboardController < ApplicationController

    def index
        @statuses = IssueStatus.all
        @issues = Issue.all
        @projects = Project.all
        # SELECT status, count(*) from issues WHERE tracker_id = 5 GROUP BY status;

        @issues_seperated_by_statuses = []
        @issues_seperated_by_order_type = []
        @issues_seperated_by_purchase_status = []

        # all purchase issues
        @purchase_issues = IssueQuery.new(:filters => {
            "tracker_id" => {:operator => "=", :values => ["5"]}
            })
        @purchase_issues_count = Issue.where(:tracker_id => 5).count

        # all purchase issues categorised by statuses
        @issues_by_statuses = Issue.where(:tracker_id => 5).group(:status).count
        @sorted_by_status_id = IssueQuery.new(:filters =>{
            "status_id" => {:operator => "=", :values => [" "]},
            "tracker_id" => {:operator => "=", :values => ["5"]}
            })
        # @issues_seperated_by_statuses << @sorted_by_status_id

        @issues_count_by_order_type = CustomValue.where(:custom_field_id => 125).group(:value).count
        @order_type_issues = IssueQuery.new(:filters => {
            "tracker_id" => {:operator => "=", :values => ["5"]},
            "status_id" => {:operator => "=", :values => ["*"]},
            "cf_125" => {:operator => "=", :values => [" "]}
            })

        @issues_count_by_purchase_status = CustomValue.where(:custom_field_id => 26).group(:value).count
        @sorted_by_purchase_status = IssueQuery.new(:filters => {
            "tracker_id" => {:operator => "=", :values => ["5"]},
            "cf_26" => {:operator => "=", :values => [" "]},
            "status_id" => {:operator => "=", :values => ["*"]}
            })
        @priorities = Enumeration.where(:type => "IssuePriority")
        @issues_count_by_priority = Issue.where(:tracker_id => 5).group(:priority_id).count
        @issues_by_priority = IssueQuery.new(:filters => {
            "tracker_id" => {:operator => "=", :values => ["5"]},
            "status_id" => {:operator => "=", :values => ["*"]},
            "priority_id" => {:operator => "=", :values => [" "]}
            })
    end
end
