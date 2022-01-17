package com.project.nadaum.culture.show.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Culture implements Serializable {

   private static final long serialVersionUID = 1L;

   private String code;
   private String title;
   private Date start_date;
   private Date end_date;
   private String area;
   private String place;
   private String realm_name;
   private String img_url;
   private int gps_x;
   private int gps_y;
}