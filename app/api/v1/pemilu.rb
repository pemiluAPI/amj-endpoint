module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :province do
      desc "Return all AMJ Province"
      get do
        amj_province = Array.new

        # Prepare conditions based on params
        valid_params = {
          province: 'province_id',
          status: 'status'
        }

        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        AmjProvince.includes(:province)
          .where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |amj|
            amj_province << {
              id: amj.id,
              province: {
                id: amj.province_id,
                name: amj.province_nama
              },
              amj_date: amj.date,
              status: amj.status
            }
          end

        {
          results: {
            count: amj_province.count,
            total: AmjProvince.where(conditions).count,
            amj: amj_province
          }
        }
      end
    end

    resource :city do
      desc "Return all AMJ City"
      get do
        amj_province = Array.new

        # Prepare conditions based on params
        valid_params = {
          province: 'province_id',
          status: 'status'
        }

        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 100 : params[:limit]

        AmjCity.includes(:province)
          .where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |amj|
            amj_province << {
              id: amj.id,
              province: {
                id: amj.province_id,
                name: amj.province_nama
              },
              city: amj.city,
              amj_date: amj.date,
              status: amj.status
            }
          end

        {
          results: {
            count: amj_province.count,
            total: AmjCity.where(conditions).count,
            amj: amj_province
          }
        }
      end
    end
  end
end