package classes;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

public class DummyDB {
    private int firstNames;
    private String data = "Alan, Albert, Alex, Bain, Brian, Carl, Chris, David, Derek, Frank, Frodo, Gary, Greg, Yaser";

    private List<String> fnames;
    public DummyDB() {
        fnames = new ArrayList<String>();
        StringTokenizer st = new StringTokenizer(data, ",");

        while(st.hasMoreTokens()) {
            fnames.add(st.nextToken().trim());
        }
        firstNames = fnames.size();
    }

    public List<String> getData(String query) {
        String searchvalue = null;
        query = query.toLowerCase();
        List<String> matched = new ArrayList<String>();
        for(int i=0; i<firstNames; i++) {
            searchvalue = fnames.get(i).toLowerCase();
            if(searchvalue.startsWith(query)) {
                matched.add(fnames.get(i));
            }
        }
        return matched;
    }
}