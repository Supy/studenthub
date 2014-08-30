class @LocationPickerTree
    constructor: (form_id) ->
        @location_field_id = if (form_id[0] == '#') then form_id else ('#' + form_id)
        @loader = $ '#location_tree_loader'
        @form_target = $ @location_field_id
        $('.location_level_picker').change @location_level_f

    build_selector: (loc_level, data) ->
        new_id = 'location_level_' + loc_level
        e = $ '<select></select>'
            .addClass 'form-control input-sm location_level_picker'
            .attr 'id', new_id
            .attr 'name', new_id
            .attr 'loc_level', loc_level
            .change @location_level_f

        # first add blank version
        e.append ($('<option></option>')
            .attr 'value', ''
            .html '----'
        )

        # then append options to match drilldown
        e.append data.children.map (c) ->
            $ '<option></option>'
                .attr 'value', c.id
                .html c.name

        # then wrap in div
        ediv = $ '<div></div>'
            .addClass 'location_level_wrapper'
            .css 'padding', 2
            .css 'padding-left', (loc_level*20-20)

        ediv.append(e)

        # return
        ediv

    load_selector: (id, ee) ->
        url = '/locations/drilldown/' + id
        $.getJSON url, (data) =>
            if data.children.length > 0
                level = $('.location_level_picker').length + 1
                ee.parent().after(@build_selector level, data)
        # return
        true

    location_level_f: (event) =>
        # the clicked element
        ee = $ event.target

        # remove any selectors after the clicked one
        ee.parent().nextAll().remove()

        # if ---- is selected, don't add another level
        if not not event.target.value
            # show the spinner
            @loader.show()

            # set location_id
            @form_target.val event.target.value

            # load next level
            @load_selector event.target.value, ee

            # hide the spinner
            @loader.hide()

        else
            level = Number(ee.attr 'loc_level') - 1
            if level == 0
                @form_target.val ''
            else
                @form_target.val $('#location_level_' + level).val()

        # return
        true
