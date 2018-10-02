SELECT * FROM (
  SELECT
      scientific_name,
      cat_num,
      ACCESSION,
      higher_geog,
      SPEC_LOCALITY,
      flat.VERBATIM_LOCALITY,
      flat.COLLECTING_METHOD,
      flat.COLLECTING_SOURCE,
      flat.BEGAN_DATE,
      flat.ENDED_DATE,
      flat.VERBATIM_DATE,
      COLL_EVENT_REMARKS,
      round(dec_lat,5) dec_lat,
      round(dec_long,5) dec_long,
      COLLECTORS,
      decode(trim(flat.sex),
        'male','M',
        'female','F',
        'male ?','M?',
        'female ?','F?',
        '') sex,
      ATTRIBUTES,
      PREPARATORS,
      PARTS,
      REMARKS,
      flat.MINIMUM_ELEVATION,
      flat.ORIG_ELEV_UNITS,
      flat.DATUM,
      ConcatAttributevalue(flat.collection_object_id,'verbatim preservation date') as verbatim_preservation_date,
      ConcatAttributevalue(flat.collection_object_id,'age class') as age_class,
      ConcatAttributevalue(flat.collection_object_id,'unformatted measurements') as unformatted_measurements,
      ConcatAttributevalue(flat.collection_object_id,'right gonad width') as right_gonad_width,
      ConcatAttributevalue(flat.collection_object_id,'left gonad width') as left_gonad_width,
      ConcatAttributevalue(flat.collection_object_id,'right gonad length') as right_gonad_length,
      ConcatAttributevalue(flat.collection_object_id,'left gonad length') as left_gonad_length,
      ConcatAttributevalue(flat.collection_object_id,'ovum') as ovum,
      ConcatAttributevalue(flat.collection_object_id,'molt condition') as molt_condition,
      ConcatAttributevalue(flat.collection_object_id,'bill length') as bill_length,
      ConcatAttributevalue(flat.collection_object_id,'bill width') as bill_width,
      ConcatAttributevalue(flat.collection_object_id,'bill depth') as bill_depth,
      ConcatAttributevalue(flat.collection_object_id,'head length') as head_length,
      ConcatAttributevalue(flat.collection_object_id,'tail length') as tail_length,
      ConcatAttributevalue(flat.collection_object_id,'tarsus length') as tarsus_length,
      ConcatAttributevalue(flat.collection_object_id,'total length') as total_length,
      ConcatAttributevalue(flat.collection_object_id,'wing chord') as wing_chord,
      ConcatAttributevalue(flat.collection_object_id,'weight') as weight,
      ConcatAttributevalue(flat.collection_object_id,'fat deposition') as fat_deposition,
      ConcatAttributevalue(flat.collection_object_id,'skull ossification') as skull_ossification,
      ConcatAttributevalue(flat.collection_object_id,'stomach contents') as stomach_contents,
      ConcatAttributevalue(flat.collection_object_id,'extension') as extension,
      ConcatAttributevalue(flat.collection_object_id,'reproductive data') as reproductive_data,
      concatsingleotherid(flat.collection_object_id,'preparator number') as preparator_number,
      concatsingleotherid(flat.collection_object_id,'original identifier') as original_identifier,
      concatsingleotherid(flat.collection_object_id,'secondary identifier') as secondary_identifier,
      concatsingleotherid(flat.collection_object_id,'collector number') as collector_number,
      habitat,
      DECODE(collection_id,'124','BOT-','130','ENTO-','126','FISH-','131','MALA-','113','MAM-','114','ORN-','115','OOL-','144','TEACH-') || cat_num formatted_cat_num,
      NVL(SUBSTR(identification_remarks, 0, INSTR(identification_remarks, '.')-1),identification_remarks) common_name,
      RELATEDCATALOGEDITEMS,
      NVL(SUBSTR(RELATEDCATALOGEDITEMS, INSTR(RELATEDCATALOGEDITEMS, '/CHAS:')+6, 100), RELATEDCATALOGEDITEMS) relationships,
      rownum AS rnum from (
        SELECT
        scientific_name,
        cat_num,
        ACCESSION,
        higher_geog,
        SPEC_LOCALITY,
        flat.VERBATIM_LOCALITY,
        flat.COLLECTING_METHOD,
        flat.COLLECTING_SOURCE,
        flat.BEGAN_DATE,
        flat.ENDED_DATE,
        flat.VERBATIM_DATE,
        COLL_EVENT_REMARKS,
        round(dec_lat,5) dec_lat,
        round(dec_long,5) dec_long,
        COLLECTORS,
        decode(trim(flat.sex),
          'male','M',
          'female','F',
          'male ?','M?',
          'female ?','F?',
          '') sex,
        ATTRIBUTES,
        PREPARATORS,
        PARTS,
        REMARKS,
        flat.MINIMUM_ELEVATION,
        flat.ORIG_ELEV_UNITS,
        flat.DATUM,
        ConcatAttributevalue(flat.collection_object_id,'verbatim preservation date') as verbatim_preservation_date,
        ConcatAttributevalue(flat.collection_object_id,'age class') as age_class,
        ConcatAttributevalue(flat.collection_object_id,'unformatted measurements') as unformatted_measurements,
        ConcatAttributevalue(flat.collection_object_id,'right gonad width') as right_gonad_width,
        ConcatAttributevalue(flat.collection_object_id,'left gonad width') as left_gonad_width,
        ConcatAttributevalue(flat.collection_object_id,'right gonad length') as right_gonad_length,
        ConcatAttributevalue(flat.collection_object_id,'left gonad length') as left_gonad_length,
        ConcatAttributevalue(flat.collection_object_id,'ovum') as ovum,
        ConcatAttributevalue(flat.collection_object_id,'molt condition') as molt_condition,
        ConcatAttributevalue(flat.collection_object_id,'bill length') as bill_length,
        ConcatAttributevalue(flat.collection_object_id,'bill width') as bill_width,
        ConcatAttributevalue(flat.collection_object_id,'bill depth') as bill_depth,
        ConcatAttributevalue(flat.collection_object_id,'head length') as head_length,
        ConcatAttributevalue(flat.collection_object_id,'tail length') as tail_length,
        ConcatAttributevalue(flat.collection_object_id,'tarsus length') as tarsus_length,
        ConcatAttributevalue(flat.collection_object_id,'total length') as total_length,
        ConcatAttributevalue(flat.collection_object_id,'wing chord') as wing_chord,
        ConcatAttributevalue(flat.collection_object_id,'weight') as weight,
        ConcatAttributevalue(flat.collection_object_id,'fat deposition') as fat_deposition,
        ConcatAttributevalue(flat.collection_object_id,'skull ossification') as skull_ossification,
        ConcatAttributevalue(flat.collection_object_id,'stomach contents') as stomach_contents,
        ConcatAttributevalue(flat.collection_object_id,'extension') as extension,
        ConcatAttributevalue(flat.collection_object_id,'reproductive data') as reproductive_data,
        concatsingleotherid(flat.collection_object_id,'preparator number') as preparator_number,
        concatsingleotherid(flat.collection_object_id,'original identifier') as original_identifier,
        concatsingleotherid(flat.collection_object_id,'secondary identifier') as secondary_identifier,
        concatsingleotherid(flat.collection_object_id,'collector number') as collector_number,
        habitat,
        DECODE(collection_id,'124','BOT-','130','ENTO-','126','FISH-','131','MALA-','113','MAM-','114','ORN-','115','OOL-','144','TEACH-') || cat_num formatted_cat_num,
        NVL(SUBSTR(identification_remarks, 0, INSTR(identification_remarks, '.')-1),identification_remarks) common_name,
        RELATEDCATALOGEDITEMS,
        NVL(SUBSTR(RELATEDCATALOGEDITEMS, INSTR(RELATEDCATALOGEDITEMS, '/CHAS:')+6, 100), RELATEDCATALOGEDITEMS) relationships

        FROM
            flat
        WHERE
            flat.collection_object_id IN (#collection_object_id#)
        ORDER BY
            scientific_name,cat_num
        )
      WHERE rownum <= 28
    ) WHERE  rnum > 14

          


    IIF(
      (AGE_CLASS EQ DE("")), IIF(
        (SEX EQ DE("")), DE(""), DE(SEX)
      ), DE(IIF(
        (DE(SEX) EQ ""),DE(AGE_CLASS),DE(AGE_CLASS & ", " & SEX)
      )
    )
  )

IIF((SEX EQ DE("")),DE(AGE_CLASS),DE(AGE_CLASS & ", " & SEX))

IIF(
  LEN(FAT_DEPOSITION) EQ 0, DE(
    IIF(
      LEN(MOLT_CONDITION) EQ 0, DE(
        IIF(
          LEN(SKULL_OSSIFICATION) EQ 0, DE(
            ""
          ),DE(
            "skull oss.: " & SKULL_OSSIFICATION)
          )
        ),DE(
          "molt: " & MOLT_CONDITION & IIF(
            LEN(SKULL_OSSIFICATION) EQ 0, DE(
              ""
            ), DE(
              "; skull oss.: " & SKULL_OSSIFICATION
            )
          )
        )
      )
    ), DE(
      "fat: " & FAT_DEPOSITION & IIF(
        LEN(MOLT_CONDITION) EQ 0, DE(
          IIF(
            LEN(SKULL_OSSIFICATION) EQ 0, DE(
              ""
            ), DE(
              "; skull oss.: " & SKULL_OSSIFICATION
            )
          )
        ), DE(
          "; molt: " & MOLT_CONDITION & IIF(
            LEN(SKULL_OSSIFICATION) EQ 0, DE(
              ""
            ), DE(
              "; skull oss.: " & SKULL_OSSIFICATION
            )
          )
        )
      )
    )
  )

  &

  IIF(
    LEN(FAT_DEPOSITION) EQ 0, DE(
      IIF(
        LEN(MOLT_CONDITION) EQ 0, DE(
          IIF(
            LEN(SKULL_OSSIFICATION) EQ 0, DE(
              ". <br>"
            ),DE(
              "skull oss.: " & SKULL_OSSIFICATION)
            )
          ),DE(
            "molt: " & MOLT_CONDITION & IIF(
              LEN(SKULL_OSSIFICATION) EQ 0, DE(
                ". <br>"
              ), DE(
                "; skull oss.: " & SKULL_OSSIFICATION  & ". <br>"
              )
            )
          )
        )
      ), DE(
        "fat: " & FAT_DEPOSITION & IIF(
          LEN(MOLT_CONDITION) EQ 0, DE(
            IIF(
              LEN(SKULL_OSSIFICATION) EQ 0, DE(
                ". <br>"
              ), DE(
                "; skull oss.: " & SKULL_OSSIFICATION
              )
            )
          ), DE(
            "; molt: " & MOLT_CONDITION & IIF(
              LEN(SKULL_OSSIFICATION) EQ 0, DE(
                ". <br>"
              ), DE(
                "; skull oss.: " & SKULL_OSSIFICATION ". <br>"
              )
            )
          )
        )
      )
    ) &


IIF(
  left_gonad_length EQ "", DE(
    ""
  ), DE(
    IIF(
      left(SEX,1) EQ "M", DE(
        "testes: L: " & left_gonad_length & " x " & left_gonad_width & ", R: " & right_gonad_length & " x " & right_gonad_width
      ), DE(
        "ovary: " & IIF(
          len(right_gonad_length) EQ 0, DE(
            left_gonad_length & " x " & left_gonad_width
          ), DE(
            "L: " & left_gonad_length & " x " & left_gonad_width & ", R: " & right_gonad_length & " x " & right_gonad_width
          )
        ) & ", LO: " & IIF(
          ovum EQ "", DE(
            "X"
          ), DE(
            ovum
          )
        )
      )
    )
  )
) & IIF(
  len(reproductive_data) EQ 0, DE(
    ""
  ),DE(
    "; " & reproductive_data & "."
  )
)
