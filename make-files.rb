PREFIXS = ['# baseURI: https://18.157.197.66:8443/eclass/',
    '# imports: http://example.org/ECLASS_Model',
    '# prefix: eclass91_sub_27_model3',
    '',
    '@prefix ECLASS_Model: <https://18.157.197.66:8443/eclass/ECLASS_Model#> .',
    '@prefix ECLASS_Entry: <https://18.157.197.66:8443/eclass/> .',
    '@prefix eclass91_sub_27_model3: <http://example.org/eclass91_sub_27_model3#> .',
    '@prefix owl: <http://www.w3.org/2002/07/owl#> .',
    '@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .',
    '@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .',
    '@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .']

write_arr = []
folder_name = ''

Dir.mkdir(File.absolute_path("./files"))

for line in File.readlines("./eclass91_sub_27_model3.ttl")
    # Current line is an IRDI?
    if line[0..16] == 'ECLASS_Model:IRDI'
        # First IRDI
        if folder_name == ''
            write_arr.clear() # drop everything read so far

        else # Not First IRDI

            # write the last IRDI's data and clear the write array
            Dir.mkdir(File.absolute_path("./files/#{folder_name}"))
            File.open(File.absolute_path("./files/#{folder_name}/.meta"), 'w') do |wf|
                PREFIXS.each {|wline| wf.puts(wline)}
                wf.puts('')
                write_arr.each {|wline| wf.puts(wline)}
            end
            puts folder_name # log out the IRDI writen
            write_arr.clear()
        end
        folder_name = line[13..-1]
        folder_name.gsub!(/\W/, '');
        line = '<./>'
    end
    line.gsub!('ECLASS_Model:IRDI', 'ECLASS_Entry:IRDI');
    write_arr << line
end
