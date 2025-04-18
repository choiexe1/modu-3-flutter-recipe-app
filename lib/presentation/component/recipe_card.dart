import 'package:flutter/material.dart';
import 'package:recipe_app/domain/model/recipe.dart';
import 'package:recipe_app/ui/color_styles.dart';
import 'package:recipe_app/ui/text_styles.dart';

class RecipeCard extends StatelessWidget {
  static const String _timerIcon = "assets/icons/timer.png";
  static const String _bookmarkIcon = "assets/icons/bookmark.png";

  final Recipe recipe;
  final VoidCallback? onCardTap;
  final VoidCallback onBookmarkTap;
  final bool showTitle;
  final bool showRating;
  final bool showAuthor;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onCardTap,
    required this.onBookmarkTap,
    this.showTitle = true,
    this.showRating = true,
    this.showAuthor = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Stack(
        children: [
          Container(
            height: 150,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(recipe.imageUrl),
                fit: BoxFit.cover,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Container(
            height: 150,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorStyles.black,
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorStyles.black.withAlpha(10),
                  ColorStyles.black.withAlpha(255),
                ],
              ),
            ),
          ),
          showRating ? _buildRating() : Container(),
          showTitle ? _buildTitle() : Container(),
          showAuthor ? _buildAuthor() : Container(),
          _buildCookTime(),
          _buildBookMarkButton(),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return Positioned(
      top: 10,
      right: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        decoration: BoxDecoration(
          color: ColorStyles.secondary20,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          spacing: 2,
          children: [
            const Icon(Icons.star, color: ColorStyles.rating, size: 16),
            Text(
              '${recipe.rating.toDouble()}',
              style: TextStyles.smallTextRegular.copyWith(
                color: ColorStyles.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      left: 10,
      width: 170,
      bottom: 22,
      child: Text(
        recipe.name,
        style: TextStyles.smallTextBold.copyWith(color: ColorStyles.white),
      ),
    );
  }

  Widget _buildAuthor() {
    return Positioned(
      left: 10,
      bottom: 10,
      child: Text(
        'By ${recipe.chef}',
        style: TextStyles.labelTextBold.copyWith(color: ColorStyles.white),
      ),
    );
  }

  Widget _buildCookTime() {
    return Positioned(
      right: 44,
      bottom: 10,
      child: Row(
        spacing: 5,
        children: [
          SizedBox(
            width: 17,
            height: 17,
            child: Image.asset(_timerIcon, color: ColorStyles.gray4),
          ),
          Text(
            '${recipe.cookTime} min',
            style: TextStyles.smallTextRegular.copyWith(
              color: ColorStyles.gray4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookMarkButton() => Positioned(
    right: 10,
    bottom: 10,
    child: GestureDetector(
      onTap: onBookmarkTap,
      key: const Key('bookmark_button'),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: recipe.bookmarked ? ColorStyles.primary80 : ColorStyles.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Image.asset(
          _bookmarkIcon,
          color: recipe.bookmarked ? ColorStyles.white : ColorStyles.gray4,
        ),
      ),
    ),
  );
}
