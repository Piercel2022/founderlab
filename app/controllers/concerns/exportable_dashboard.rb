module ExportableDashboard
  
    extend ActiveSupport::Concern
  
    def export
      respond_to do |format|
        format.csv { send_data generate_csv, filename: "dashboard-#{Time.current.to_i}.csv" }
        format.xlsx { send_data generate_excel, filename: "dashboard-#{Time.current.to_i}.xlsx" }
        format.pdf { send_data generate_pdf, filename: "dashboard-#{Time.current.to_i}.pdf" }
        format.json { render json: dashboard_data }
      end
    end
  
    private
  
    def generate_csv
      CSV.generate do |csv|
        csv << csv_headers
        dashboard_data.each do |data|
          csv << data.values
        end
      end
    end
  
    def generate_excel
      Axlsx::Package.new do |p|
        p.workbook.add_worksheet(name: "Dashboard") do |sheet|
          sheet.add_row csv_headers
          dashboard_data.each do |data|
            sheet.add_row data.values
          end
        end
      end.to_stream.read
    end
  
    def generate_pdf
      WickedPdf.new.pdf_from_string(
        render_to_string(
          template: 'dashboard/export_pdf',
          layout: 'pdf'
        )
      )
    end
  
    def dashboard_data
      {
        metrics: export_metrics,
        charts: export_charts,
        tables: export_tables,
        activities: export_activities
      }
    end
  
    def export_metrics
      current_user.dashboard_metrics.map do |metric|
        {
          name: metric.name,
          value: metric.value,
          change: metric.change_percentage,
          period: metric.period
        }
      end
    end
end