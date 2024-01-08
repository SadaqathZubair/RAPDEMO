CLASS lhc_ZDMO_R_RAPG_ProjectTPD DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Project RESULT result.

    METHODS createProjectAndRootNode FOR MODIFY
      IMPORTING keys FOR ACTION Project~createProjectAndRootNode RESULT result.
    METHODS CalculateBoName FOR DETERMINE ON SAVE
      IMPORTING keys FOR Project~CalculateBoName.

ENDCLASS.

CLASS lhc_ZDMO_R_RAPG_ProjectTPD IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD createProjectAndRootNode.

    CONSTANTS mycid_rapbonode TYPE abp_behv_cid VALUE 'My%CID_rapbonode' ##NO_TEXT.

    DATA create_rapbonode_cba TYPE TABLE FOR CREATE ZDMO_R_RAPG_ProjectTPD\_Node.
    DATA create_rapbo TYPE TABLE FOR CREATE ZDMO_R_RAPG_ProjectTPD.

    DATA create_rapbonode_cba_line TYPE STRUCTURE FOR CREATE ZDMO_R_RAPG_ProjectTPD\_Node.
    DATA create_rapbo_line TYPE STRUCTURE FOR CREATE ZDMO_R_RAPG_ProjectTPD.

    DATA object_name TYPE if_xco_gen_o_finding=>tv_object_name .
    DATA abap_object_directory_entry  TYPE zdmo_cl_rap_xco_lib=>t_abap_obj_directory_entry  .
    DATA package_name TYPE zdmo_cl_rap_xco_lib=>t_abap_obj_directory_entry-ABAPPackage.
    DATA object_type TYPE zdmo_cl_rap_xco_lib=>t_abap_obj_directory_entry-ABAPObjectType.
    DATA object_category TYPE zdmo_cl_rap_xco_lib=>t_abap_obj_directory_entry-ABAPObjectCategory.

    DATA has_semantic_key TYPE abap_bool.
    DATA is_managed TYPE abap_bool.
    DATA does_not_use_unmanaged_query TYPE abap_bool.

    DATA(xco_lib) = zdmo_cl_rap_xco_lib=>create_xco_lib( ).

    LOOP AT keys INTO DATA(ls_key).

      TRY.
          "dummy fix
          DATA(node) = NEW ZDMO_cl_rap_noded( xco_lib ) .

          "get package of datasource

          object_name = ls_key-%param-data_source_name.

          DATA(data_source_type) = ls_key-%param-DataSourceType.

          CASE data_source_type.
            WHEN ZDMO_cl_rap_noded=>data_source_types-table.
              object_category = 'TABL'.
              object_type = 'R3TR'.
            WHEN ZDMO_cl_rap_noded=>data_source_types-cds_view.
              object_category = 'DDLS'.
              object_type = 'R3TR'.
            WHEN ZDMO_cl_rap_noded=>data_source_types-abstract_entity.
              object_category = 'DDLS'.
              object_type = 'R3TR'.
            WHEN OTHERS.
              "@todo raise exception
          ENDCASE.

          xco_lib->get_abap_obj_directory_entry(
                   EXPORTING
                     i_abap_object_type            = object_category
                     i_abap_object_category        = object_type
                     i_abap_object                 = object_name
                   RECEIVING
                     r_abap_object_directory_entry = abap_object_directory_entry
                 ).

*      package_name = abap_object_directory_entry-ABAPPackage.

          package_name = ls_key-%param-package_name.

          "get transport request
          node->set_package( package_name ).
          node->set_namespace(  ).
          node->set_transport_request(  ).
          node->set_data_source_type( CONV #( ls_key-%param-DataSourceType ) ).
          node->set_data_source( CONV #( ls_key-%param-data_source_name ) ).
*

        CATCH zdmo_cx_rap_generator INTO DATA(fill_node_object_exception).
          APPEND VALUE #( %cid = ls_key-%cid ) TO failed-project.
          APPEND VALUE #( %cid = ls_key-%cid
*                        %state_area   = 'VALIDATE_QUANTITY'
                          %msg = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text     = fill_node_object_exception->get_text( ) )
                        ) TO reported-project.
          RETURN.
      ENDTRY.

      IF ls_key-%param-DataSourceType = ZDMO_cl_rap_noded=>data_source_types-abstract_entity.
        does_not_use_unmanaged_query = abap_false.
      ELSE.
        does_not_use_unmanaged_query = abap_true.
      ENDIF.

      CASE ls_key-%param-BdefImplementationType.
        WHEN ZDMO_cl_rap_noded=>bdef_implementation_type-managed.
          is_managed = abap_true.
          IF node->is_uuid_based(  ).         .
            DATA(implementation_type) = ZDMO_cl_rap_noded=>implementation_type-managed_uuid.
          ELSE.
            implementation_type = ZDMO_cl_rap_noded=>implementation_type-managed_semantic.
            has_semantic_key = abap_true.
          ENDIF.
        WHEN ZDMO_cl_rap_noded=>bdef_implementation_type-unmanaged.
          implementation_type = ZDMO_cl_rap_noded=>implementation_type-unmanaged_semantic.
          has_semantic_key = abap_true.
      ENDCASE.

      "make sure that for abstract entities

*      DATA(fields) = node->lt_all_fields.

      DATA(package) = xco_lib->get_package( package_name ).
      DATA(software_compontent) = package->read(  )-property-software_component.
      DATA(abap_language_version_number) = xco_lib->get_abap_language_version( package_name ).

      CASE abap_language_version_number.
        WHEN ZDMO_cl_rap_noded=>package_abap_language_version-standard.
          DATA(abap_language_version) = ZDMO_cl_rap_noded=>abap_language_version-standard.
        WHEN ZDMO_cl_rap_noded=>package_abap_language_version-abap_for_sap_cloud_platform.
          abap_language_version = ZDMO_cl_rap_noded=>abap_language_version-abap_for_cloud_development.
        WHEN OTHERS.
          "abap language version of package is not supported
          ASSERT 1 = 2.
      ENDCASE.

      create_rapbo_line = VALUE #(  %is_draft = if_abap_behv=>mk-on
                                %cid      = ls_key-%cid
                                rootentityname   = ls_key-%param-EntityName
                                packagename = package_name
                                Namespace = node->namespace
                                abaplanguageversion = abap_language_version "ls_key-%param-language_version
                                PackageLanguageVersion = abap_language_version_number
                                draftenabled = ls_key-%param-DraftEnabled
                                implementationtype = implementation_type
                                datasourcetype = ls_key-%param-DataSourceType
                                BindingType = ls_key-%param-BindingType
                                TransportRequest = node->transport_request
                                "boolean fields to hide / show fields in the UI
                                hasSematicKey    = has_semantic_key
                                doesNotUseUnmanagedQuery = does_not_use_unmanaged_query
                                isManaged = is_managed
                                PublishService = abap_true
                                            ).


      create_rapbonode_cba_line = VALUE #(  %is_draft = if_abap_behv=>mk-on
                                        %cid_ref  = ls_key-%cid
                                        %target   = VALUE #( (
                                                               %is_draft = if_abap_behv=>mk-on
                                                               %cid      = mycid_rapbonode
                                                               entityname = ls_key-%param-entityname
                                                               isrootnode = abap_true
                                                               DataSource = ls_key-%param-data_source_name
                                                               hierarchydistancefromroot = 0
                                                               ) ) ) .


      APPEND create_rapbo_line TO create_rapbo.
      APPEND create_rapbonode_cba_line TO create_rapbonode_cba.

    ENDLOOP.

    MODIFY ENTITIES OF zdmo_r_rapg_projecttpd IN LOCAL MODE
            ENTITY Project
            CREATE FIELDS ( rootentityname packagename Namespace
                            abaplanguageversion PackageLanguageVersion
                            draftenabled implementationtype datasourcetype bindingtype
                            hasSematicKey doesNotUseUnmanagedQuery isManaged
                            TransportRequest PublishService )
                  WITH create_rapbo
                  CREATE BY \_Node
                  FIELDS ( entityname isrootnode hierarchydistancefromroot DataSource )
                  WITH create_rapbonode_cba
            MAPPED   mapped
            FAILED   failed
            REPORTED reported.

    CHECK mapped-project[] IS NOT INITIAL.

    DATA test_key TYPE STRUCTURE FOR ACTION IMPORT zdmo_r_rapg_projecttp~check_allowed_combinations_det.
    DATA test_keys TYPE TABLE FOR ACTION IMPORT zdmo_r_rapg_projecttp~check_allowed_combinations_det.


    LOOP AT mapped-project INTO DATA(mapped_project).
      APPEND VALUE #( %cid = ls_key-%cid
                      %param = VALUE #( %is_draft = mapped_project-%is_draft
                                        %key      = mapped_project-%key ) ) TO result.
      test_key-RapBoUUID = mapped_project-RapBoUUID.
      test_key-%is_draft = mapped_project-%is_draft.
      APPEND test_key TO test_keys.

    ENDLOOP.


*    MODIFY ENTITIES OF zdmo_r_rapg_projecttp IN LOCAL MODE
*           ENTITY Project
*           EXECUTE check_allowed_combinations_det
*           FROM test_keys
*              MAPPED   mapped
*              FAILED   failed
*              REPORTED reported.

*"set values for node object in global class
*      zdmo_bp_rapg_all=>rap_bo_nodes[ uuid = mapped-project[ 1 ]-%key-RapBoUUID
*
*    DATA rap_bo_node TYPE zdmo_bp_rapg_all=>t_rap_bo_node.
*    TRY.
*        LOOP AT mapped-project INTO mapped_project.
*          rap_bo_node-uuid = mapped_project-RapBoUUID.
*          rap_bo_node-node = node.
*        ENDLOOP.



  ENDMETHOD.

  METHOD CalculateBoName.
  ENDMETHOD.

ENDCLASS.
