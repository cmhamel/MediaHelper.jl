module MediaHelper

using Dates
using ExifViewer

function gather_images(folder::String)
    @assert isdir(folder) "Folder $folder not doesn't exist"
    image_files = String[]
    for (path, dirs, files) in walkdir(folder)
        for f in files
            ext = lowercase(splitext(f)[2])
            if ext == ".gif"
                @warn "Skipping .gif file for now"
            elseif ext == ".jpg" || ext == ".jpeg"
                push!(image_files, joinpath(folder, f))
            elseif ext == ".mov"
                @warn "Skipping .mov file for now"
            elseif ext == ".png"
                # @warn "Skipping png for now"
                push!(image_files, joinpath(folder, f))
            else
                @assert false "Unsupported file type $(splitext(f)[2])"
            end
        end
    end
    return image_files
end

function organize_images(folder::String; organized_folder::String = "organized")
    if isdir(organized_folder)
        rm(organized_folder; force = true, recursive = true)
    end
    mkdir(organized_folder)
    mkdir(joinpath(organized_folder, "unorganized"))
    images_to_organize = gather_images(folder)
    meta_datas = read_tags.(images_to_organize)
    for (f, meta_data) in zip(images_to_organize, meta_datas)
        if meta_data == Dict()
            cp(f, joinpath(organized_folder, "unorganized", basename(f)))
        else
            # @info f
            if haskey(meta_data, "EXIF_TAG_DATE_TIME_DIGITIZED")
                @info f
                if "GPS" in keys(metadata)
                    @assert false "Found a GPS key"
                end
                display(keys(meta_data) |> collect |> sort)
                meta_data["EXIF_TAG_DATE_TIME_DIGITIZED"]
                dt = parse_exif_datetime(meta_data["EXIF_TAG_DATE_TIME_DIGITIZED"])
                ym = Dates.format(dt, "yyyy-mm")
                # @show ym
                ym_dir = joinpath(organized_folder, ym)
                if !isdir(ym_dir)
                    mkdir(ym_dir)
                end
                cp(f, joinpath(ym_dir, basename(f)))
            else
                cp(f, joinpath(organized_folder, "unorganized", basename(f)))
            end
        end
    end
    # for im in images_to_organize
    #     meta_data = read_tags(im)
    #     if meta_data == Dict()
    #         @show im
    #     end
    # end
end

function parse_exif_datetime(s::AbstractString)
    DateTime(s, dateformat"yyyy:mm:dd HH:MM:SS")
end

end # module MediaHelper
