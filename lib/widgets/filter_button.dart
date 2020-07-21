import 'package:appwrite_project/blocs/filtered_tasks/filtered_tasks_bloc.dart';
import 'package:appwrite_project/models/visibility_filter.dart';
import 'package:appwrite_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterButton extends StatelessWidget {
  final bool visible;
  FilterButton({this.visible, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilteredTasksBloc, FilteredTasksState>(
      builder: (context, state) {
        final defaultStyle = Theme.of(context).textTheme.bodyText1;
        final activeStyle = Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(color: Theme.of(context).accentColor);
        final button = _Button(
          onSelected: (filter) {
            BlocProvider.of<FilteredTasksBloc>(context)
                .add(FilterUpdated(filter));
          },
          activeFilter: state is FilteredTasksLoadSuccess
              ? state.activeFilter
              : VisibilityFilter.all,
          activeStyle: activeStyle,
          defaultStyle: defaultStyle,
        );
        return AnimatedOpacity(
          opacity: visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 150),
          child: visible ? button : IgnorePointer(child: button),
        );
      },
    );
  }
}

class _Button extends StatelessWidget {
  const _Button(
      {Key key,
      @required this.onSelected,
      @required this.activeFilter,
      @required this.activeStyle,
      @required this.defaultStyle})
      : super(key: key);

  final PopupMenuItemSelected<VisibilityFilter> onSelected;
  final VisibilityFilter activeFilter;
  final TextStyle activeStyle;
  final TextStyle defaultStyle;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VisibilityFilter>(
      key: TasksKeys.filterButton,
      tooltip: 'filter task',
      //  tooltip: ArchSampleLocalizations.of(context).filterTodos,
      onSelected: onSelected,
      itemBuilder: (BuildContext context) => <PopupMenuItem<VisibilityFilter>>[
        PopupMenuItem<VisibilityFilter>(
          key: TasksKeys.allFilter,
          value: VisibilityFilter.all,
          child: Text(
            'show all',
            // ArchSampleLocalizations.of(context).showAll,
            style: activeFilter == VisibilityFilter.all
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: TasksKeys.activeFilter,
          value: VisibilityFilter.active,
          child: Text(
            'show active',
            //  ArchSampleLocalizations.of(context).showActive,
            style: activeFilter == VisibilityFilter.active
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: TasksKeys.favouriteFilter,
          value: VisibilityFilter.favourite,
          child: Text(
            'show favourite',
            // ArchSampleLocalizations.of(context).showCompleted,
            style: activeFilter == VisibilityFilter.favourite
                ? activeStyle
                : defaultStyle,
          ),
        ),
        PopupMenuItem<VisibilityFilter>(
          key: TasksKeys.completedFilter,
          value: VisibilityFilter.completed,
          child: Text(
            'show completed',
            // ArchSampleLocalizations.of(context).showCompleted,
            style: activeFilter == VisibilityFilter.completed
                ? activeStyle
                : defaultStyle,
          ),
        ),
      ],
      icon: Icon(Icons.filter_list),
    );
  }
}
