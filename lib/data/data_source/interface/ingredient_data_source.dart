import 'package:recipe_app/data/data_source/interface/data_source.dart';
import 'package:recipe_app/domain/model/ingredient.dart';

abstract interface class IngredientDataSource
    implements DataSource<Ingredient> {}
