class Tables {
  static String categories() {
    return """
      create table if not exists categories(
        id varchar(250) primary key not null,
        label varchar(40) unique not null
      );
    """;
  }

  static String notes() {
    return """
      create table if not exists notes(
        id varchar(250) primary key not null,
        title varchar(40) not null,
        category varchar(40) default 'none',
        favourite bool default 'f',
        created_at timestamp not null default current_timestamp
      );
    """;
  }

  static String paragraphs() {
    return """
      create table if not exists paragraphs(
        id varchar(250) primary key not null,
        note_id varchar(250) not null references notes(id),
        description varchar(2000) default 'none',
        path varchar(2000) default 'none',
        link varchar(200) default 'none', 
        type varchar(20) default 'none'
      );
    """;
  }
}
