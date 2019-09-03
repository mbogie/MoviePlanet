public class MPCastAndCrewWrapper {

    public Integer id {get;set;}
    @AuraEnabled public List<Cast_Z> cast_Z {get;set;} // in json: cast

    public class Cast_Z {
        @AuraEnabled public String character {get;set;}
        @AuraEnabled public String id {get;set;}
        @AuraEnabled public String name {get;set;}
        @AuraEnabled public String profile_path {get;set;}

        public Cast_Z(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'character') {
                            character = parser.getText();
                        } else if (text == 'id') {
                            id = parser.getText();
                        } else if (text == 'name') {
                            name = parser.getText();
                        } else if (text == 'profile_path') {
                            profile_path = parser.getText();
                        } else {
                            //System.debug(LoggingLevel.WARN, 'Cast_Z consuming unrecognized property: '+text);
                        }
                    }
                }
            }
        }
    }

    public MPCastAndCrewWrapper(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'id') {
                        id = parser.getIntegerValue();
                    } else if (text == 'cast') {
                        cast_Z = arrayOfCast_Z(parser);
                    } else {
                       // System.debug(LoggingLevel.WARN, 'MPCast consuming unrecognized property: '+text);
                    }
                }
            }
        }
    }

    private static List<Cast_Z> arrayOfCast_Z(System.JSONParser p) {
        List<Cast_Z> res = new List<Cast_Z>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Cast_Z(p));
        }
        return res;
    }
}