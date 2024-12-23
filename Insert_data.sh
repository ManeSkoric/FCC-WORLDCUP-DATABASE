#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != "year" ]]
then
POBEDNIK=$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")

  if [[ -z $POBEDNIK ]]
  then
  UNESI_POBEDNIKA=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
 
  fi


GUBITNIK=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")
  if [[ -z $GUBITNIK ]]
  then
  UNESI_GUBITNIKA=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
  fi


POBEDNIK_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

GUBITNIK_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")


UNESI_MEC=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $POBEDNIK_ID, $GUBITNIK_ID, $WINNER_GOALS, $OPPONENT_GOALS)")

fi
#echo $YEAR, $ROUND, $POBEDNIK_ID, $GUBITNIK_ID, $WINNER_GOALS, $OPPONENT_GOALS
#echo 'KRAJ RUNDE KRAJ RUNDE KRAJ RUNDE'
done 
