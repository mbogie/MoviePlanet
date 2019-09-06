public class MPActorFilmographyWrapper {

    public List<Cast_Z> cast_Z {get;set;} // in json: cast
    public Integer id {get;set;}

    public MPActorFilmographyWrapper(JSONParser parser) {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) {
            if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                String text = parser.getText();
                if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                    if (text == 'cast') {
                        cast_Z = arrayOfCast_Z(parser);
                    } else if (text == 'id') {
                        id = parser.getIntegerValue();
                    }
                }
            }
        }
    }

    public class Cast_Z {
        @AuraEnabled public String character {get;set;}
        @AuraEnabled public String title {get;set;}
        @AuraEnabled public String id {get;set;}
        @AuraEnabled public String poster_path {get;set;}
        @AuraEnabled public String source {get;set;}
        @AuraEnabled public String fbtype {get;set;}

        public Cast_Z(JSONParser parser) {
            while (parser.nextToken() != System.JSONToken.END_OBJECT) {
                if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
                    String text = parser.getText();
                    if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
                        if (text == 'character') {
                            character = parser.getText();
                        } else if (text == 'title') {
                            title = parser.getText();
                        } else if (text == 'id') {
                            id = parser.getText();
                        } else if (text == 'poster_path') {
                            poster_path = parser.getText();
                        }
                    }
                }
            }
        }
    }

    private static List<Integer> arrayOfInteger(System.JSONParser p) {
        List<Integer> res = new List<Integer>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(p.getIntegerValue());
        }
        return res;
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